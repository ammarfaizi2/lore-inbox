Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWGEX6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWGEX6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWGEX6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:58:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:10578 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965076AbWGEX6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:58:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bbRJvyTRy6XoC3M0C0DvcovyKrB4p0rGMflNvWOkh+XJdkdWnDehP+cFbs51fvZCRRQazvULIN+BcDiTN/DjGrEdnTnBJ1nOVBMd/7ED2q+beHzw/TDbh3MQJffmSu0kpBYSYimYFerwYG6YerpeWs6XKFVv6D17Y1zyJWn6d1c=
Message-ID: <bda6d13a0607051658j7cbadc1en89f07196f1f00e27@mail.gmail.com>
Date: Wed, 5 Jul 2006 16:58:04 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
In-Reply-To: <200607060940.40678.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
	 <klibc.200606272217.30@tazenda.hos.anvin.org>
	 <200607060940.40678.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll take my own guess that kinit reads the kernel command line and
handles both resume= and noresume itself. I've done that with a few
other cases, so it is certainly possible.
