Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTLSN2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 08:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTLSN2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 08:28:17 -0500
Received: from holomorphy.com ([199.26.172.102]:3991 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263513AbTLSN2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 08:28:15 -0500
Date: Fri, 19 Dec 2003 05:28:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.6.0 on IBM 600X
Message-ID: <20031219132806.GO31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>,
	linux-kernel@vger.kernel.org
References: <pan.2003.12.19.13.22.08.801900@interlinx.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.12.19.13.22.08.801900@interlinx.bc.ca>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 08:22:09AM -0500, Brian J. Murrell wrote:
> Trying to boot 2.6.0 on an IBM 600X (I have seen a report of the same with
> a 600E as well) I get the following 100% reproducable error and stack trace:
> devfs_remove: ide/host0/bus0/target0/lun0 not found, cannot remove

devfs is not really in a state to be used (maybe it should be removed);
could you try without?


-- wli
