Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRI3WkU>; Sun, 30 Sep 2001 18:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274080AbRI3WkL>; Sun, 30 Sep 2001 18:40:11 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:33285 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S273888AbRI3Wj7>; Sun, 30 Sep 2001 18:39:59 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: [OT] New Anti-Terrorism Law makes "hacking" punishable by life in prison
Date: Sun, 30 Sep 2001 15:40:27 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBEEOFDNAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3BB7918E.E74A3BE4@pobox.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of J Sloan
> Sent: Sunday, September 30, 2001 2:42 PM

[snip]

> OK, the obvious question:
>
> If apache is 60% of the market and IIS is 25%
> (and I have heard that apache on Linux is about
> 33% of the web server market) how do you see
> that as windows/iis being more popular than the
> linux/apache platform? and yet, windows/iis has
> the lions share of vulnerabilities - your arguments
> lie in tatters....

We need to distinguish between Linux/Apache and other-UNIX/Apache.
Specifically, there's at least Solaris, Tru64 and AIX besides Linux in this
market. It isn't just IIS; the Nimda beast exploited, IIRC, 18 separate
vulnerabilities in the Windows / IIS complex, including shared files.

I've actually heard of cases where *Linux* systems exporting filesystems
with Samba had Nimda code stuffed down their throats! If this code had been
Linux-executable rather than Windows-executable -- if the virus had been
smart enough to know it was dealing with a Samba rather than a Windows share
and had been able to differentiate between Windows executables and Linux
executables -- hmmm ... do you see what I'm getting at??? In other words,
UNIX systems of *all* stripes that export filesystems with Samba need to
track mods to executables just like a virus scanner does on a Windows
system. *That's* what I mean by vigilance.

[snip]

> I think Unix's long history of multiuser, networked
> operation gives it quite a bit more sophistication in
> areas of security, as opposed to windows, a single
> user system which has in the past few years
> become widely networked.

The security features are there in Windows if the users and sysadmins are
willing to implement them. Windows NT has had C2 available for quite some
time; they couldn't sell to DOD if they didn't. A good MSCE / security
specialist makes a lot of money. It's for the most part laziness on the part
of Windows users that allows malicious code to circulate, not any inherent
weakness in the Microsoft tool set. The technology exists.

> I'm not saying Linux/Unix users should rest on their
> laurels or be lulled into a sense of false security, but
> come on, let's at least be realistic about the very real
> advantages of Unix OSes over PC OSes in this area.

I don't see any such advantage. C2 is C2; crypto is crypto; authentication
is authentication; vigilance is vigilance.

Here, for your amusement, is a snippet of Perl code:

$stuff = `uname`;
if ($stuff =~ /is not recognized as an internal or external command,/ {
	# execute malicious Windows code
}
else {
	# look at the uname stuff and figure out what OS we're running
	# then execute OS-specific malicious code
}

Do you see what I'm saying?
--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net  http://www.aracnet.com/~znmeb
mailto:znmeb@borasky-research.net  mailto:znmeb@aracnet.com

Q: How do you tell when a pineapple is ready to eat?
A: It picks up its knife and fork.

