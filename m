Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbTJPU2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbTJPU2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:28:23 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:19584
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S263148AbTJPU2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:28:21 -0400
Message-ID: <3F8EFFEC.6010402@trash.net>
Date: Thu, 16 Oct 2003 22:30:36 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test7: XFS fills files with 0-bytes after crash
References: <3F8EF3BB.6090602@trash.net>
In-Reply-To: <3F8EF3BB.6090602@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently this is a known problem, no need for further replies.
Thanks to the people who responded.

Best regards,
Patrick

Patrick McHardy wrote:

> I recently encountered a problem with XFS: while hacking on some 
> network stuff
> I crashed my box multiple times. Every time I saved a file directly 
> before the crash
> XFS filled the file with 0-bytes (I assume at recovery). The file size 
> was unchanged.
> Syncing and waiting a couple of seconds before crashing the box 
> helped. To confirm
> my network hacking didn't accidentally damage XFS data structures I 
> created a
> module which does nothing more than dereferencing a NULL pointer in 
> softirq
> context, the problem persisted.
>
> ver_linux:
>
> Gnu C                  3.3.2
> Gnu make               3.80
> util-linux             2.12
> mount                  2.12
> module-init-tools      0.9.15-pre2
> e2fsprogs              1.35-WIP
> xfsprogs               2.5.11
> nfs-utils              1.0.5
> Linux C Library        2.3.2
> Dynamic linker (ldd)   2.3.2
> Procps                 3.1.12
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               5.0.91
> Modules Loaded         sch_hfsc iptable_filter ipt_MARK iptable_mangle 
> ip_tables cls_fw oprofile nfsd exportfs deflate zlib_deflate twofish 
> serpent aes blowfish des sha256 sha1 md5 af_key 8250 serial_core nfs 
> lockd sunrpc af_packet snd_pcm_oss snd_mixer_oss snd_ens1371 
> snd_rawmidi snd_seq_device snd_pcm snd_page_alloc snd_timer 
> snd_ac97_codec snd soundcore 8139too mii rtc unix
>
> xfsprogs 2.5.11-1 (debian)
>
> If more specific information is required please tell me ..
>
> Best regards,
> Patrick



