Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSERQzP>; Sat, 18 May 2002 12:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSERQzO>; Sat, 18 May 2002 12:55:14 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:38095 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S313305AbSERQzN>; Sat, 18 May 2002 12:55:13 -0400
Message-ID: <3CE6863A.2070806@linuxhq.com>
Date: Sat, 18 May 2002 12:50:02 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
In-Reply-To: <86256BBD.00223AD9.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:
> 
> Someone said here on the list a few months ago that "make bzlilo" was replaced
> by "make install" and that it was necessary to configure the "install" option's
> behavior.
> 

Actually, the "install behavior" is quite nice.  I wrote a script that 
installs the kernel and sets it up in the right way for my 
non-kbuild-2.5 kernel... much of this script is doing stuff like getting 
the current kernel version, etc... the new kbuild allows you to specify 
the install script you want to use and exports a bunch of variables that 
make this script easier to write.  Moreover, I believe there is a 
default install that mimicks that of the current kernel so that the 
changing of install's behavior is not mandatory.



