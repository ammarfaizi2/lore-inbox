Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVBMTIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVBMTIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 14:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBMTHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 14:07:45 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:53488 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261293AbVBMTHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 14:07:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=V6wArXLpf1qEOlk8tif4kLlt57N1EfZZcxVRsrcdwHirxDRN4lcEMBk/RY+gK9RJSh84kRdaIqFtbZ2IupE+bhKiKw4WAOx8ndEXvROVBYaeMIy9ofRREN4Yd2luM9CVOCEGA4XFHvgPzRUNXHg2AIoV+PFWkTXfFeiBGe4Kzjg=
Message-ID: <a71293c205021311071a7cf4d7@mail.gmail.com>
Date: Sun, 13 Feb 2005 14:07:39 -0500
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20050207101417.GB16443@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c20502031443764fb4e5@mail.gmail.com>
	 <20050205104405.GA1401@elf.ucw.cz> <20050207101417.GB16443@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005 11:14:17 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > Perhaps this should be done in userspace? It is probably usable on
> > non-trackpoint devices, too...
> 
> For a big part it's not possible to do in userspace, because the
> touchpoint doesn't give the pressure information, it only can be mapped
> to a button click.
> 
> But middle-button-to-scroll would be doable in userspace, yes.
> 

Middle-to-scroll in the newer Xorg releases. I received a number of
requests from users to include this feature, I'm not sure why the Xorg
option is inadequate. It can be removed if necessary.


Stephen
