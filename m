Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVKGRXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVKGRXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVKGRXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:23:30 -0500
Received: from william.ironicdesign.com ([216.180.99.12]:14811 "EHLO
	william.ironicdesign.com") by vger.kernel.org with ESMTP
	id S965303AbVKGRX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:23:27 -0500
From: Michael Alan Dorman <mdorman@tendentious.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
References: <20051106013752.GA13368@swissdisk.com>
	<436E17CA.3060803@gentoo.org>
	<1131316729.1212.58.camel@localhost.localdomain>
	<436F81D1.7000100@gentoo.org>
	<1131383311.11265.22.camel@localhost.localdomain>
	<1131383144.2477.9.camel@capoeira>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 07 Nov 2005 12:23:34 -0500
In-Reply-To: <1131383144.2477.9.camel@capoeira> (Xavier Bestel's message of
	"Mon, 07 Nov 2005 18:05:44 +0100")
Message-ID: <87hdaoxtgp.fsf@hero.mallet-assembly.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> writes:
> On Mon, 2005-11-07 at 18:08, Alan Cox wrote:
>> On Llu, 2005-11-07 at 16:33 +0000, Daniel Drake wrote:
>> > Source RPM's will just contain a Linux kernel tree with your patches already 
>> > applied, right?
>> 
>> Of course not. Its an rpm file. RPM files contain a set of broken out
>> patches and base tar ball plus controlling rules for application. It's
>> rather more advanced than .deb sources.
>
> That's a troll, Alan. .deb contain exactely the same things.

Some packages use dpatch and related tools like this, and give you a
pristine upstream tarball and broken-out patches, but it is not
supported at the level that RPMs do---which is to say, in the core
tool.

Seriously, I pulled apart a whole lot of RPMs when I was doing the
first real (libc6) port of Debian to the Alpha in '96, and it was a
lot easier than dealing with the generally mashed-together patches in
a debian package's .diff.gz.

Mike
