Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267653AbTAaAEk>; Thu, 30 Jan 2003 19:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267654AbTAaAEk>; Thu, 30 Jan 2003 19:04:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24845 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267653AbTAaAEk>;
	Thu, 30 Jan 2003 19:04:40 -0500
Message-ID: <3E39BF4B.2010000@pobox.com>
Date: Thu, 30 Jan 2003 19:11:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: David Brownell <david-b@pacbell.net>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: pci_set_mwi() ... why isn't it used more?
References: <3E2C42DF.1010006@pacbell.net> <20030120190055.GA4940@gtf.org> <3E2C4FFA.1050603@pacbell.net> <20030130135215.GF6028@krispykreme> <3E3951E3.7060806@pacbell.net> <20030130195944.A4966@jurassic.park.msu.ru> <3E39706D.6080400@pacbell.net> <20030131023419.A652@localhost.park.msu.ru>
In-Reply-To: <20030131023419.A652@localhost.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> Thoughts?


Seems sane to me...  I agree it's aggressive, because you're changing 
behavior of pci_set_master().  But given that the MWI stuff in pci.c is 
so new, I think that's probably ok.

