Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTEMFY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTEMFY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:24:57 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:12549 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262883AbTEMFY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:24:56 -0400
Date: Tue, 13 May 2003 06:37:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: unique entry points for all driver hosts
Message-ID: <20030513063726.A2799@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Mukker, Atul" <atulm@lsil.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E570185F192@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F192@EXA-ATLANTA.se.lsil.com>; from atulm@lsil.com on Mon, May 12, 2003 at 06:41:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 06:41:50PM -0400, Mukker, Atul wrote:
> Why doesn't mid-layer allow LLDs to specify separate entry points to various
> hosts attached to the same driver. 

Just declare multiple host templates.  If you use sccsi_add_host instead
of the crufty obsolete interfaces it'll work out nicely.
