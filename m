Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTH1XCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbTH1XCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:02:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55687 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264320AbTH1XCj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:02:39 -0400
Date: Fri, 29 Aug 2003 00:02:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828230233.GD10035@mail.jlokier.co.uk>
References: <200308281726.SAA24033@mauve.demon.co.uk> <E19sUna-0003Zq-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19sUna-0003Zq-00@calista.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> In article <200308281726.SAA24033@mauve.demon.co.uk> you wrote:
> > I'd be really surprised if there were that many pictures in the world.
> 
> Well, this is about probabilty. It does not mean that you need 2^64
> pictures, neighter does it mean you have a collision within 2^64 pictures.

It just means that if you have a collision with many fewer pictures
than that, it's such an unlikely event that a flaw in the program
calculating the hash, or a flaw in the hash algorithm itself, is more
likely than it being a random collision.

-- Jamie

