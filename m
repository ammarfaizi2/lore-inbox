Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318780AbSG0QPz>; Sat, 27 Jul 2002 12:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318782AbSG0QPz>; Sat, 27 Jul 2002 12:15:55 -0400
Received: from holomorphy.com ([66.224.33.161]:33443 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318780AbSG0QPz>;
	Sat, 27 Jul 2002 12:15:55 -0400
Date: Sat, 27 Jul 2002 09:18:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: sisfb driver irq fixups
Message-ID: <20020727161856.GN25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
References: <20020727160325.GA29221@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020727160325.GA29221@outpost.ds9a.nl>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 06:03:25PM +0200, bert hubert wrote:
> Already sent to Thomas,

This actually needs to be a lock against concurrent modification of
fb_display[] as it appears other things get at the data under the lock
without taking the lock you introduced.


Cheers,
Bill
