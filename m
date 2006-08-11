Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWHKV1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWHKV1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHKV1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:27:00 -0400
Received: from rune.pobox.com ([208.210.124.79]:29075 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S932284AbWHKV07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:26:59 -0400
Date: Fri, 11 Aug 2006 16:26:49 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Message-ID: <20060811212649.GN3233@localdomain>
References: <44D99F1A.4080905@de.ibm.com> <20060811211915.GL3233@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811211915.GL3233@localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:

> Hope all the callers of this function are in non-atomic context (but I
> wasn't able to find any callers?).

Never mind, I somehow missed the users of ehea_hcall_9arg_9ret in this
patch, sorry.
