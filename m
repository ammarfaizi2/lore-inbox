Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbVCaA6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVCaA6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCaA6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:58:09 -0500
Received: from 17.red-62-57-106.user.auna.net ([62.57.106.17]:45256 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S262589AbVCaA57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:57:59 -0500
Date: Thu, 31 Mar 2005 02:57:57 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Cc: "H. J. Lu" <hjl@lucon.org>, Andi Kleen <ak@muc.de>,
       binutils@sources.redhat.com
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment
 register access)
In-Reply-To: <20050331003437.GB19573@lucon.org>
Message-ID: <Pine.LNX.4.62.0503310253180.7060@pau.intranet.ct>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org>
 <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org>
 <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org>
 <20050330040017.GA29523@lucon.org> <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org>
 <20050330210801.GA15384@lucon.org> <Pine.LNX.4.62.0503310015490.7060@pau.intranet.ct>
 <20050331003437.GB19573@lucon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, H. J. Lu wrote:

>>> That is what the assembler generates, and should have generated, for
>>> "movw %ds,(%eax)" since Nov. 4, 2004.
>>
>> Could this be the reason for the reported slowdown in the last six months?
>
> Can you elaborate?

There's an unexplained slowdown of kernel 2.6 detailed in this thread:
http://kerneltrap.org/node/4940

I don't want at all to justify it with the change you talk about in gas, 
but maybe it is worth to check if it has anything to do with it. The 
slowdown happened in this last six months.

-- 

Pau
