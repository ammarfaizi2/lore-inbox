Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUJYOMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUJYOMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUJYOKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:10:20 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60608 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261822AbUJYOJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:09:46 -0400
Date: Mon, 25 Oct 2004 16:09:43 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kbuild dependencies and layout
In-Reply-To: <1098661432l.6459l.0l@werewolf.able.es>
Message-ID: <Pine.LNX.4.61.0410251556430.17266@scrub.home>
References: <1098661432l.6459l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 24 Oct 2004, J.A. Magallon wrote:

> A_GENERIC_FEATURE_1 is valid for both submodels. Logic is right, but
> gconfig insists on putting AF1 as a subentry of A_2, instead of hanging
> it in the menu. I would like:
> 
>  A support
>   \- A-1
>   \- A-2
>   \- AF1 (visible only when A-1 or A-2 are selected)
>   \- AF2 (visible only when A-1 or A-2 are selected)

Could you please post a real example? There are two possibilities and it 
depends on the context.
Part of the problem might also be that gconfig uses by default the full 
tree mode, that doesn't automatically expands the new options, otherwise 
I don't really see a problem with indenting these two suboptions.

bye, Roman
