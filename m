Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWAEES5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWAEES5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 23:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWAEES5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 23:18:57 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:196 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751921AbWAEES4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 23:18:56 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Date: Thu, 5 Jan 2006 05:15:03 +0100
User-Agent: KMail/1.8.2
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
References: <20051227215351.3d581b13.khali@linux-fr.org> <1135949941.25274.1.camel@localhost> <20051231193956.4271e2f0.khali@linux-fr.org>
In-Reply-To: <20051231193956.4271e2f0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601050515.07205.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 31 December 2005 19:39, Jean Delvare wrote:

> So I believe that "choice" is an interesting Kconfig feature when used
> with boolean options, but with modules I am not convinced, especially
> when these modules have different dependencies.

Well, I'm always open to suggestions (or even better patches) to improve 
tristate choices. Such interdependent options have to be done via a choice 
group, so they are handled correctly handled by kconfig, otherwise you have 
to live with the current compromise. OTOH how they are mapped to the user 
interface is easily changeable.

bye, Roman
