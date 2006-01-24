Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWAXSQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWAXSQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWAXSQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:16:55 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:22327 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932276AbWAXSQz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:16:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ieb3vVy6TVbZ9zF2lzMmmHxoID7w1q9OnnPzr/pQeN475BGfbD2xyvjpoFQYrx7tvRhN5sH2mWyZx3o0DKFxh0aWeJMfhONRtiOgJbzEtXyM4GyOXUULn1hNUoapimuZcfu3r62NV7E1U1HAbwZOGoElM2fByegizCeF6dsbCRE=
Date: Tue, 24 Jan 2006 19:16:28 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is /sound not in /drivers/media?
Message-Id: <20060124191628.ea45e543.diegocg@gmail.com>
In-Reply-To: <20060124171249.GA8406@stiffy.osknowledge.org>
References: <20060124171249.GA8406@stiffy.osknowledge.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 24 Jan 2006 18:12:49 +0100,
Marc Koschewski <marc@osknowledge.org> escribió:

> Hi everybody,
> 
> I just asked myself why the /sound tree is not within /drivers/media right
> besides /drivers/media/video. Wouldn't that make sense? Could the movement be


IIRC, because ALSA maintainers though that sound/ are not just drivers, but
also a subsystem just like net/. Network drivers are in drivers/net however.
