Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317891AbSHHTlK>; Thu, 8 Aug 2002 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317905AbSHHTlK>; Thu, 8 Aug 2002 15:41:10 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:36592 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317891AbSHHTlJ>; Thu, 8 Aug 2002 15:41:09 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0208081336420.26999-100000@rancor.yyz.somanetworks.com> 
References: <Pine.LNX.4.33.0208081336420.26999-100000@rancor.yyz.somanetworks.com> 
To: "Scott Murray" <scottm@somanetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Aug 2002 20:44:49 +0100
Message-ID: <21750.1028835889@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


scottm@somanetworks.com said:
>  you have any objection to this boot time reservation stuff going in
> for now as a cPCI only thing?  I can imagine other solutions that use
> DMI scans or the like to detect cPCI master cards and grab chunks of
> the resource space(s) for the hotswap buses, but don't have any clever
> ideas on reliable heuristics for knowing how big those chunks should
> be for a given card.

No objections. I can't see any 'proper' fix other than adding the ability 
to relocate live cards. And I don't reckon that's going to happen.

--
dwmw2


