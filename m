Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVETVVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVETVVI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 17:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVETVVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 17:21:08 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:56468 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261588AbVETVVD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 17:21:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uvAJNbtaInp9iyUkj5eWIvQ4+wSzSBXyLqHEAijasUZM4nEThIittbs22KzB1q4oZlnjMg/NzFLpBGKy5ude6RLp7kYBlZsmVScVl1yMDnoksxBgDZrC+9LuJ0JB3PgbNga2rV76eRGX6Xwao7dXV8641Ghepc6EYcT9J1Y0b/I=
Message-ID: <9e4733910505201421cf36902@mail.gmail.com>
Date: Fri, 20 May 2005 17:21:03 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-os@analogic.com
Subject: Re: Screen regen buffer at 0x00b8000
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0505201612360.6833@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
	 <Pine.LNX.4.58.0505201259560.2206@ppc970.osdl.org>
	 <Pine.LNX.4.61.0505201612360.6833@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/05, Richard B. Johnson <linux-os@analogic.com> wrote:
> On Fri, 20 May 2005, Linus Torvalds wrote:
> Yes, and I didn't want to. However a customer wants some status to
> be always displayed in the upper-right-hand corner of a 4x5 LCD
> with a tiny CPU board.

The console implements a tiny terminal emulator. Does the emulator
implement the escape sequence for locking an unscrollable line at the
top of the screen? If so lock the line, write your info there, and the
rest of the display will work like normal.

-- 
Jon Smirl
jonsmirl@gmail.com
