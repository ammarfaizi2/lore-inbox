Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbUKSNz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbUKSNz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUKSNz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:55:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:423 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261401AbUKSNzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:55:22 -0500
Date: Fri, 19 Nov 2004 08:54:52 -0500
From: Alan Cox <alan@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, alan@redhat.com
Subject: Re: linux-2.4.28 released
Message-ID: <20041119135452.GA10422@devserv.devel.redhat.com>
References: <BF571719A4041A478005EF3F08EA6DF05EB481@pcsmail03.pcs.pc.ome.toshiba.co.jp> <20041118111235.GA26216@logos.cnet> <20041119134832.GA9552@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119134832.GA9552@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 08:48:32AM -0500, Jeff Garzik wrote:
> PATA and SATA (DMA doesn't work for PATA, in split-driver configuration),
> and there is no split-driver to worry about.
> 
> I think there may need to be some code to prevent the IDE driver from
> claiming the legacy ISA ports.

Its called "request_resource". If you want the resource claim it. IDE will
be a good citizen.

Alan

