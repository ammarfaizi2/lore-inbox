Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756356AbWKWS00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356AbWKWS00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 13:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbWKWS00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 13:26:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:3655 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755210AbWKWS0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 13:26:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RiQpZk5pyf/gjtZBC0XWJ4hulYAGB2cNOS0fzL34FUkhOpu2Dlwfa12y1fLkiDnOctQXghbaUBlpUE90UfbHSHq3Zqu2TZ1zx/LkCPdyPMw++mhgAGX+khe4cXf2bJOi5W+5gcnBJr6Xk8KBqJnRKV4AVkEjtxacbjp6GbmMAEo=
Message-ID: <41840b750611231026r790cd327q7e48ebd99f9b9350@mail.gmail.com>
Date: Thu, 23 Nov 2006 20:26:24 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Cc: "Christoph Schmid" <chris@schlagmichtod.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20061121205124.GB4199@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <455DAF74.1050203@schlagmichtod.de> <20061121205124.GB4199@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/06, Pavel Machek <pavel@ucw.cz> wrote:
> I'm afraid we need your help with development here. Porting old patch
> to 2.6.19-rc6 should be easy

http://lkml.org/lkml/2006/10/9/84
http://lkml.org/lkml/2006/10/10/275

> Does hdaps work for you, btw? It gave all zeros on my x60, iirc.

Yes, vanilla hdaps is broken. It blindly issues commands to the
embedded controller without following the protocol or checking the
status. The patched version in the tp_smapi package fixes it.

  Shem
