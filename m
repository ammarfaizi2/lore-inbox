Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTBXQe6>; Mon, 24 Feb 2003 11:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBXQe6>; Mon, 24 Feb 2003 11:34:58 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:28427 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267204AbTBXQe5>; Mon, 24 Feb 2003 11:34:57 -0500
Date: Mon, 24 Feb 2003 16:45:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hartmut Manz <manz@intes.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: INTEL SCSI-Controler (gdth) does not compile on LINUX 2.5.62
Message-ID: <20030224164509.A8306@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hartmut Manz <manz@intes.de>, linux-kernel@vger.kernel.org
References: <200302241721.10321.manz@intes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302241721.10321.manz@intes.de>; from manz@intes.de on Mon, Feb 24, 2003 at 05:21:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 05:21:10PM +0100, Hartmut Manz wrote:
> I was trying to run linux.2.5.62 on one of my machines.
> 
> The machine is a Dual-Xeon System with a 4-way striped filesystem on an INTEL SCSI-controler.
> So I need the following option in .config
> CONFIG_SCSI_GDTH=y
> 
> With Linux 2.4.20 all is ok, but while compile linux-2.5.62 I got the following messages.

This driver needs a major overhaul to work in Linux 2.5.

