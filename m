Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWBCT3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWBCT3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWBCT3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:29:08 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:24197 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030225AbWBCT3G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:29:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aVQ6F4At3qRYKq37GqvcEB2/wu07eYixmhaldtWCvHacC9pgb/wJQ+eQwCXC9qXp16GgiqEQ+bOTEwsDtvndjw1WJqkeaFEZnlCvOhMs6xbXP4czF1GfCp7oHHlfpYnc+uHQvfzM5sp9RCBVa2xkMZ/DKfH7seNnWZQF3OlMY2w=
Message-ID: <7c3341450602031129t1770fa9ao@mail.gmail.com>
Date: Fri, 3 Feb 2006 19:29:05 +0000
From: Nick <nick@linicks.net>
Reply-To: Nick <nick@linicks.net>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [2.6.16rc2] compile error
Cc: Alexander Fieroch <fieroch@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060203190126.GA28929@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ds08vk$hk$1@sea.gmane.org>
	 <20060203190126.GA28929@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are hit be an outstanding issue with -rc1 + rc2.
> When you build as root you will alter /dev/null and in your case it
> became a regular file.
>
> Recreate /dev/null and build as normal user for now.
> You can apply patch below to fix it - will be in next -rc.

Although this is fixed, can/should /dev/null be made immutable?  I
presume the whole system relies on it...

Nick
