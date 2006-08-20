Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWHTQRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWHTQRx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWHTQRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:17:53 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:39067 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750854AbWHTQRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:17:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rwvdD1gz/vT4tPny9A/T5oBUmLxwCoB100nfWLXg2OhWb1aEEnGS0y3SNyx1UIs0pfaiDQUqB8XV5iy2QYu4oa80k5n/jI5N3BrOvSxHn8JdWrNKLkGBnq6tix89ih0ytYlo76XdX1/NMJd7T7hAP39b8GCu9j9XebVuNuJkLq8=
Message-ID: <18d709710608200917o4c062d6ewd216580a1022ad0f@mail.gmail.com>
Date: Sun, 20 Aug 2006 13:17:51 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.17.9 Incorrect string length checking in param_set_copystring()
In-Reply-To: <18d709710608200747k3323b23cq70eb52fdb9032554@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18d709710608200747k3323b23cq70eb52fdb9032554@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As for 2.6.17.9, linux/include/linux/moduleparam.h suggests the user
> of module_param_string() to set the maxlen parameter to
> strlen(string), ie. '\0' excluded.

Actually, sizeof(string), not strlen(string). Senseless typo here.
Sorry, my bad. :)

Cheers,

    Julio Auto
