Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310197AbSCFV1G>; Wed, 6 Mar 2002 16:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310202AbSCFV1B>; Wed, 6 Mar 2002 16:27:01 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:31762 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310197AbSCFV0o>;
	Wed, 6 Mar 2002 16:26:44 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Vincent Bernat <bernat@free.fr>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: xmms segfaulting on 2.4.18 and 2.4.19-pre2-ac2 + oops 
In-Reply-To: Your message of "Wed, 06 Mar 2002 16:35:29 BST."
             <m3pu2hn1z2.fsf@neo.loria> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Mar 2002 08:26:32 +1100
Message-ID: <19185.1015449992@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Mar 2002 16:35:29 +0100, 
Vincent Bernat <bernat@free.fr> wrote:
>EIP:    0010:[3c59x:__insmod_3c59x_S.bss_L40+828820/101914768]    Not tainted
>Call Trace: [3c59x:__insmod_3c59x_S.bss_L40+829092/101914496] [3c59x:__insmod_3c59x_S.bss_L40+828820/101914768] [3c59x:__insmod_3c59x_S.bss_L40+829678/101913910] [3c59x:__insmod_3c59x_S.bss_L40+817016/101926572] [3c59x:__insmod_3c59x_S.bss_L40+802037/101941551] 
>I can't use the sound card any more (already used). xmms wasn't using
>the network. I didn't do a ksymoops on the another oops but it was
>located on 3c59x too.

The oops is not in 3c59x.  You are letting klogd convert the oops and
klogd has been broken for years.  <rant>Why do distributors insist on
shipping such broken code?</rant>.  Always run klogd with the -x flag
to keep its sticky fingers off the oops then you can get clean data for
ksymoops to decode.

