Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbUJ3Cp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbUJ3Cp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 22:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbUJ3Cp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 22:45:26 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:32923 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S262614AbUJ3CpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 22:45:07 -0400
Message-ID: <4183002A.4070202@esoterica.pt>
Date: Sat, 30 Oct 2004 03:44:58 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041005
X-Accept-Language: pt, pt-br
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: K 2.6.9 - NFS: lstat causes "permission errors"
References: <418294CD.8000507@esoterica.pt> <4182FED2.8010000@esoterica.pt>
In-Reply-To: <4182FED2.8010000@esoterica.pt>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

I am sorry, but the error occurs when "lstat" and "open". Not "read".

