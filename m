Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135714AbRARXdI>; Thu, 18 Jan 2001 18:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136176AbRARXc6>; Thu, 18 Jan 2001 18:32:58 -0500
Received: from mail08.voicenet.com ([207.103.0.34]:33176 "HELO mail08")
	by vger.kernel.org with SMTP id <S135714AbRARXcm>;
	Thu, 18 Jan 2001 18:32:42 -0500
Message-ID: <3A677D17.8000701@voicefx.com>
Date: Thu, 18 Jan 2001 18:32:39 -0500
From: "John O'Donnell" <johnod@voicefx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010115
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Fredrickson <lists@frednet.dyndns.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA chipset discussion
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com> <20010118020408.A4713@iname.com> <20010118121356.A28529@frednet.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Fredrickson wrote:

> On Thu, Jan 18, 2001 at 02:04:08AM -0200, Rogerio Brito wrote:
> 
>> On Jan 17 2001, David D.W. Downey wrote:
>> 
>>> Could those that were involved in the VIA chipset discussion email me
>>> privately at pgpkeys@hislinuxbox.com?
>> 
>> 	Just to add a datapoint to the discussion, I'm using a VIA
>> 	chipset here (in fact, it's an Asus A7V board with a Duron), a
>> 	2.2.18 kernel with André's patches and I'm only using IDE
>> 	(UDMA/66 and UDMA/33 here) and I'm *not* seeing any problems.
> 
> 
> BTW, are you having any trouble with your ps/2 mouse port in X?  On my new
> ASUS board, ps/2 mouse devices (just in X, gpm works fine) act a little
> crazy (random mouse movement, random clicking, etc., except I'm not the
> one doing all the random movement).  I'm not sure what it is, though I do
> know it's not as bad once I upgraded from 2.2.18pre21 to 2.4.0.  I think
> I'm going to try using the mouse as a usb device and see if I still have
> trouble.  Anyway, just wondering if you're seeing the same problem.

I have the ASUS CUV4X.
VIA vt82c686a (cf/cg) IDE UDMA66 controller on pci0:4.1
I also run DMA66 with no problems here.

I never have seen any issues with the PS/2 mouse and X.
I use the Logitech cordless wheel mouse.  I use the "MouseManPlusPS/2"
driver in XFree.  When I was first setting this up (about a year ago)
I had the problems you mention.  I read an article on setting up your
scroll wheel in X and it said to use the IMPS/2 setting.  This was
nothing but trouble, till I RTFM on XFree and mice and found my solution.
Can you tell us what kind of mouse this is and how you have it set up in
XFree.

Let's take this mouse discussion off list as it has nuttin to do with
the kernel....
Johnny O

-- 
<SomeLamer> what's the difference between chattr and chmod?
<SomeGuru> SomeLamer: man chattr > 1; man chmod > 2; diff -u 1 2 | less
	-- Seen on #linux on irc
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell (Sr. Systems Engineer, Net Admin, Webmaster, etc.) |
| Voice FX Corporation (a subsidiary of Student Advantage)          |
| One Plymouth Meeting         |     E-Mail: johnod@voicefx.com     |
| Suite 610                    |           www.voicefx.com          |
| Plymouth Meeting, PA 19462   |         www.campusdirect.com       |
+==============================+====================================+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
