Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWBURwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWBURwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWBURwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:52:50 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:2315 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751194AbWBURwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:52:50 -0500
Date: Tue, 21 Feb 2006 18:52:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] duplicate #include check for build system
Message-ID: <20060221175246.GA9070@mars.ravnborg.org>
References: <20060221014824.GA19998@MAIL.13thfloor.at> <Pine.LNX.4.64.0602210149190.6773@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602210149190.6773@iabervon.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 02:29:12AM -0500, Daniel Barkalow wrote:
> On Tue, 21 Feb 2006, Herbert Poetzl wrote:
 
> I think the kernel style is to encourage duplicate includes, rather than 
> removing them. Removing duplicate includes won't remove any dependancies 
> (since the includes that they duplicate will remain).
The style as I have understood it is that each .h file in include/linux/
are supposed to be self-contained. So it includes what is needs, and the
'what it needs' are kept small.

Keeping the 'what it needs' part small is a challenge resulting in
smaller .h files. But also a good way to keep related things together.

	Sam
