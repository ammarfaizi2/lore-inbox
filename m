Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWFPL5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWFPL5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWFPL5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:57:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:35819 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751124AbWFPL5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:57:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MaIs0XRE+ZEJZrXVSBn3VPft/7bnI7aSecWE05s6xQWjYFi64RFgKg7jWKrAaddqusIlqovUAPfD0xnSOnwWKGRvrDZ1AsVbEt7ZOxlzhjQ4Mb4V303xWSeV9GRJJrrmYIRugshf/faNch2zLFfWfPT8JalyYphJT78TqmQu+Rg=
Message-ID: <c6114db60606160457y556db534u920d044e7f6dab24@mail.gmail.com>
Date: Fri, 16 Jun 2006 13:57:13 +0200
From: "Salvatore Sanfilippo" <antirez@gmail.com>
To: "Marcus Metzler" <mocm@mocm.de>
Subject: Re: v4l device in userspace
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17554.39454.563004.916138@mocm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c6114db60606160403g5e02becctbf2a67db7011ec9a@mail.gmail.com>
	 <17554.39454.563004.916138@mocm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/06, Marcus Metzler <mocm@mocm.de> wrote:

> Sounds like you should take a look at the v4l loopback device

Thanks this may contain useful code indeed.

> Anyway, since you already capture the video, why do you have to pipe
> it through a v4l device?

In order to make every application using the v4l API
working with the phone cam without modifications.

Thanks,
Salvatore

-- 
Salvatore 'antirez' Sanfilippo
We're programmers. Programmers are, in their hearts, architects -- Joel Spolsky
http://www.invece.org
