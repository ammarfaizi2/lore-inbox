Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268987AbUHYAZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268987AbUHYAZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269115AbUHYAZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:25:27 -0400
Received: from mailgate2.sover.net ([209.198.87.64]:50168 "EHLO mx2.sover.net")
	by vger.kernel.org with ESMTP id S268987AbUHYAZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:25:22 -0400
Message-ID: <412BDC86.8000608@sover.net>
Date: Tue, 24 Aug 2004 20:25:42 -0400
From: Stephen Wille Padnos <spadnos@sover.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fraga@abusar.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>    <20040824184245.GE5414@waste.org>    <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org> <cggjvs$bv9$1@sea.gmane.org>
In-Reply-To: <cggjvs$bv9$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dâniel Fraga wrote:

>	I always update my kernel when the official patch is announced and
>I'd expect to follow a well defined order (2.6.8 -> 2.6.8.1 ->
>2.6.9...).
>
>	Suppose we had 2.6.8.1, 2.6.8.2, 2.6.8.3 until 2.6.8.10. Should I
>remove 10 patches just to update to 2.6.9? For me it's a waste of time.
>  
>
You wouldn't have to.  The patch method from 2.6.8.x to 2.6.8.x+1 would 
be this:
unpatch 2.6.8.x
patch 2.6.8.x+1

Actually, going from any patch sublevel to any other is the same two 
steps: remove the last patch level, patch to the new level.

- Steve

