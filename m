Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTKCROa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbTKCROa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:14:30 -0500
Received: from gateway.caplin.com ([195.110.77.253]:57613 "EHLO
	gateway.caplin.com") by vger.kernel.org with ESMTP id S262198AbTKCRO3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:14:29 -0500
Message-ID: <3FA68CD1.80608@driscollnewsletter.com>
Date: Mon, 03 Nov 2003 17:13:53 +0000
From: Luke Driscoll <news.cis@driscollnewsletter.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031009
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NFS on 2.6.0-test9
References: <NN6j.pY.25@gated-at.bofh.it> <NPhU.42k.19@gated-at.bofh.it>
In-Reply-To: <NPhU.42k.19@gated-at.bofh.it>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> Luke Driscoll <newsregister@driscollnewsletter.com> writes:
> 
> 
>>On a kernel 2.6.0-test9 as an NFS client I am having trouble transferring
>>data to and from NFS servers. It it extraordinarily slow.  I receive the
>>following information in dmesg:
>>
>>nfs warning: mount version older than kernel
> 
> 
> I see that one, too.  Apart from that, it appears to work.  Try the
> tcp option, and see if it helps.
> 
tcp option seems to have helped, except when attempting to mount a 
redhat 9 nfs server.  Mount says:
"nfs server reported service unavailable: Address already in use"




