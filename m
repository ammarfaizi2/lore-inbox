Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271333AbRIVPNA>; Sat, 22 Sep 2001 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271486AbRIVPMt>; Sat, 22 Sep 2001 11:12:49 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:54802 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271333AbRIVPMj>;
	Sat, 22 Sep 2001 11:12:39 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Crutcher Dunnavant <crutcher@datastacks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Whats in the wings for 2.5 (when it opens) 
In-Reply-To: Your message of "Sat, 22 Sep 2001 10:31:00 -0400."
             <20010922103100.C9352@mueller.datastacks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Sep 2001 00:44:53 +1000
Message-ID: <28866.1001169893@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2001 10:31:00 -0400, 
Crutcher Dunnavant <crutcher@datastacks.com> wrote:
>++ 22/09/01 12:59 +1000 - Keith Owens:
>> Post kbuild 2.5 I will be writing a generic parameter/command line
>> interface so you can insmod foo bar=99 or boot with foo.bar=99.  You
>> will even be able to boot with foo.bar=99 when foo is a module, insmod
>> will use the command line as a default set of values.
>
>Well, that certainly is clean. How deep does it go?

One level, flat.  Module names must be unique, -DKBUILD_OBJECT runs off
module names.

