Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWBFRUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWBFRUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWBFRUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:20:32 -0500
Received: from [84.204.75.166] ([84.204.75.166]:3716 "EHLO shelob.oktetlabs.ru")
	by vger.kernel.org with ESMTP id S932242AbWBFRUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:20:31 -0500
Message-ID: <43E7855B.3080900@yandex.ru>
Date: Mon, 06 Feb 2006 20:20:27 +0300
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION/sysfs] strange refcounting
References: <1139040821.13125.4.camel@sauron.oktetlabs.ru> <43E4985D.3070708@yandex.ru> <43E4AD2F.1020703@yandex.ru> <43E71DA8.3020103@yandex.ru>
In-Reply-To: <43E71DA8.3020103@yandex.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artem B. Bityutskiy wrote:
> In connection with this, I have a question. There is a whole bunch of 
> drivers which do not directly relate to hardware devices, but which 
> still want to expose their parameters via sysfs. For example, this could 
> be a filesystem, LVM, a compression layer on top of a file system of a 
> block device, whatever. These are "virtual" devices and they are not 
> physically connected to any bus. How should they deal with sysfs?

For some reasons I missed Greg's reply to my first message and was 
talking to myself. To end this thread, the answer to this question is: 
"include/sysfs.h".

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
