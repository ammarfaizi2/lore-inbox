Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUAaWK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUAaWK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 17:10:58 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:47523 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265137AbUAaWK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 17:10:57 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sat, 31 Jan 2004 22:41:25 +0100
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org, molnar@elte.hu,
       phil-list@redhat.com
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131214125.GD2160@kiste>
References: <20040131104606.GA25534@kiste> <20040131153743.GA13834@outpost.ds9a.nl> <20040131155155.GA1504@kiste> <20040131161805.GA15941@outpost.ds9a.nl> <20040131181518.GB1815@kiste> <20040131191923.GA21333@outpost.ds9a.nl> <20040131204914.GB2160@kiste> <20040131211826.GA24791@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131211826.GA24791@outpost.ds9a.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

bert hubert:
> This means your situation is different from what you describe. Python may
> not in fact be doing 'real' threading on your setup.

Well, the strace was from Python, so probably I was missing something...
but I can't think of anything not-real which Python does, except that it
does synchronize its internal state with MANY futex calls.  ;-)

> make the smallest possible python program that exhibits the program and send
> it to the list.
> 
I'll do that.

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
