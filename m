Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVBZAfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVBZAfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVBZAfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:35:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:13511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261311AbVBZAfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:35:52 -0500
Date: Fri, 25 Feb 2005 16:40:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: panagiotis.issaris@mech.kuleuven.ac.be
Cc: takis@lumumba.luc.ac.be, prism54-devel@prism54.org,
       linux-kernel@vger.kernel.org
Subject: Re: prism54 not releasing region
Message-Id: <20050225164054.2c512daf.akpm@osdl.org>
In-Reply-To: <20050226010126.A28793@lumumba.luc.ac.be>
References: <20050226010126.A28793@lumumba.luc.ac.be>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris <takis@lumumba.luc.ac.be> wrote:
>
> To my newbie eye it looked as if the region requested at line 154
> weren't released in case of the line 166 failure handling. Is
> my assumption right?

It is.  I can take care of this patch for you, thanks.
