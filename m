Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266293AbRGJNTq>; Tue, 10 Jul 2001 09:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbRGJNTg>; Tue, 10 Jul 2001 09:19:36 -0400
Received: from adalivecom-cv.sdsl.shore.net ([209.58.158.210]:716 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266293AbRGJNT0>; Tue, 10 Jul 2001 09:19:26 -0400
Date: Tue, 10 Jul 2001 09:18:57 -0400 (EDT)
From: Aaron Longfield <aaronl@adalive.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problems booting 2.4.6 ac release
In-Reply-To: <000901c1090a$05e37440$78eb400a@zurich.com.au>
Message-ID: <Pine.LNX.4.33.0107100916280.25235-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

Did you happen to compile IrDA into the kernel?  This has been broken for
at least with 2.4.5. there are fixes in the -ac patches that have not been
applied to the mainstream kernel yet.  If you compile IrDA as a module, or
use -acXX, the kernel will be able to proceed to exec'ing INIT.

-Aaron Longfield

On Tue, 10 Jul 2001, Chris Massam wrote:

%Hello,
%
%I'm having problems booting linux on my IBM Thinkpad A20 laptop.
%
%Having got the machine working nicely with Debian "woody" I decided to
%upgrade to 2.4.5 - which caused no end of problems, as it would fail to boot
%correctly.
%
%It would freeze at:
%
%Freeing unused memory 242k ...
%
%So, at the point I upgraded to -ac23 which worked fine.
%So then 2.4.6 comes along, and I have exactly the same problem.
%
%Are the 'ac' release not incorportated into future releases?
%
%Thanks for any help in advance.
%
%Chris

