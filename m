Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVADQJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVADQJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVADQJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:09:40 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:11017 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261712AbVADQHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:07:52 -0500
Message-ID: <41DABF37.30207@tuleriit.ee>
Date: Tue, 04 Jan 2005 18:07:19 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: starting with 2.7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2005, at 07:36, Al Viro wrote:
 > On Tue, Jan 04, 2005 at 06:46:49AM +0100, Willy Tarreau wrote:
 > > On Mon, Jan 03, 2005 at 10:14:42PM +0000, Christoph Hellwig wrote:
 > > > > Gosh! I bought an ATI video card, I bought a VMware license, 
etc.... I
 > > > > want to keep using them. Changing a "stable" kernel will 
continuously
 > > > > annoy users and vendors.
 > > >
 > > > So buy some Operating System that supports the propritary software of
 > > > your choice but stop annoying us.
 > >
 > > That's what he did. But it was not written in the notice that it 
could stop
 > > working at any time :-)
 >
 >
 >     Do you want a long list of message-IDs going way, way back? Ones 
of Linus'
 >     postings saying that there never had been any promise whatsoever 
of in-kernel
 >     interfaces staying unchanged...


Eh? "you should avoid Linux - experimental project indeed!". Sad, but 
this is almost true already: can you name the stable version of the 
kernel which is in main public use? When I take a look from distros then:

Mandrake 10.2 snapshot (Cooker): kernel-2.6.8.1.20mdk-1-1mdk.i586.rpm

SuSe (SRPM for new 9.2): kernel-source-2.6.8-24.src.rpm

Fedora (update for FC3): kernel-2.6.9-1.724_FC3.i686.rpm


And inside proper .src.rpm-s are lot of stuff. So how those fixes inside 
2.6.10 will reach the end-user? 2.6.[x < 10] + patch+patch+patch...

It means that for end user (me) the stable kernel 2.6.10 is not just 
usable. And of course I will not test any vanilla kernel because my MIDI 
programs-devices/USB gadgets/connect+point+and+click will usually stop 
working by reasons which are not bug but implementation related. So what 
I should report to my distro provider? Please recode this program 
because i am keen to test newest kernel? But how then should I provide 
my help with kernel testing?

Maybe you need to set up a pool of patches with full detailed information:
- bug fixes
- security related fixes
- feature changes
- status flag: test/stable
- dependencies :)

This is what is needed - how and when a 2.6.x stable kernel will have 
released (strategy of kernel development) is not a question at all. 
Vanilla kernel will never reach end-users anyway.
OK, don't take it too seriously :)

regards,
Indrek

