Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263541AbUJ3E64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbUJ3E64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 00:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbUJ3E64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 00:58:56 -0400
Received: from [82.154.232.115] ([82.154.232.115]:3754 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S263541AbUJ3E6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 00:58:55 -0400
Message-ID: <41831F8D.5000606@vgertech.com>
Date: Sat, 30 Oct 2004 05:58:53 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: K 2.6.9 - NFS: lstat causes "permission errors"
References: <418294CD.8000507@esoterica.pt> <4182FED2.8010000@esoterica.pt>
In-Reply-To: <4182FED2.8010000@esoterica.pt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olá Paulo,

Paulo da Silva wrote:
> Paulo da Silva wrote:
> 
>> I am getting several "permission errors" when using
>> "lstat". So far I only found this on Directories.
>> I changed a program to retry the "lstat" whenever
>> a "permission error" occurs and it works successfully.
>>
> I'm also getting "Stale NFS file handle" error when "lstat" and
> "read"  a file. This seems to happen only on a VFAT filesystem
> but I am not sure.

Are you exporting a FAT fs with NFS? It's expected to break in some 
situations. Read http://nfs.sourceforge.net/nfs-howto/server.html

Regards,
Nuno Silva

