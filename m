Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWGGVKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWGGVKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWGGVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:10:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:6835 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932277AbWGGVKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:10:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V9GeL0CikfouTAq569w6BnOC6eglwHrH7/JEL3FI6ilWrpyf07rWYDR5ivmlacxXuW+jt9h1/3/tCWoorzFg1KOCd/6Bq4FUcO/kFt9ufKX2VAeUusCBEA40a1pIadqD6hiR2Sxz3BzUL6KFRy9rQ+TZzRZuc3dkm0xNrMwJ3gM=
Message-ID: <9e0cf0bf0607071410y4c460a1ayb0ce925bacbc1881@mail.gmail.com>
Date: Sat, 8 Jul 2006 00:10:38 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: Re: swsusp / suspend2 reliability
Cc: "Jan Rychter" <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
In-Reply-To: <018b01c6a1fb$59f74b80$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m2k66qzgri.fsf@tnuctip.rychter.com>
	 <018b01c6a1fb$59f74b80$493d010a@nuitysystems.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/06, Hua Zhong <hzhong@gmail.com> wrote:
> Greg had a good article on LWN: http://lwn.net/Articles/189467/. There you could find a more painful truth. You know what the real
> reason is that suspend2 couldn't get merged? Not Nigel, not Pavel, but Linus, because he personally doesn't care. So if you want to
> have a high-quality suspend-to-disk, your best bet is to convince Linus to use it. :-)
>

True.
That's right.
In the past someone called it a lack of leadership...

But reading the references you introduced, I've first realized in how
deep problem we, the user community who want to use suspend-to-disk
and not suspend-to-ram, are.

It is so pity that the whole suspend (ram AND disk) process is not
addressed as a whole... Just because Linus does not care.

And if suspend-to-disk is more complex, it should be solved first,
since suspend-to-ram can be a subset of the process (Although people
in the past dismissed this claim... :( ).

So I guess we will continue to use suspend2 for a long while... Since
at least someone cares, and have a vision reacher than hay I can do
this in userspace.

Best Regards,
Alon Bar-Lev.
