Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267674AbTBRGdM>; Tue, 18 Feb 2003 01:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267675AbTBRGdM>; Tue, 18 Feb 2003 01:33:12 -0500
Received: from rth.ninka.net ([216.101.162.244]:63876 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267674AbTBRGdM>;
	Tue, 18 Feb 2003 01:33:12 -0500
Subject: Re: 2.5.61: x86_64 num_online_cpus() buglet?
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <20030218063111.GA14073@wotan.suse.de>
References: <200302171751.SAA19069@kim.it.uu.se> 
	<20030218063111.GA14073@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Feb 2003 23:27:05 -0800
Message-Id: <1045553225.4501.11.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-17 at 22:31, Andi Kleen wrote:
> You're right - it should use hweight64. Thanks for the headup.
> I'll fix it.

Can someone finally add a hweight64() to the generic code?
I've been avoiding usage of hweight64() anywhere for this
very reason.

