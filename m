Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWBUV5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWBUV5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWBUV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:57:21 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:33037 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964858AbWBUV5U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:57:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ru7yu0eT5yga/wpeZT9YaaGCiUwyVy5WKf6SSEkDKnI5mz6ZBY9KuGRCxb/ULCk5cL0Kti0xg4t3W1MilUX1uTM5rj9h+jwZXGE1/6n5b9/tVGTdVKy7b010PCJhlyqYTcA3Ei9lFcHJKh9/2OdcqHXi/efe5YP5KTK52BfI4bk=
Message-ID: <d120d5000602211357h48fb19cbu82ad596266271514@mail.gmail.com>
Date: Tue, 21 Feb 2006 16:57:19 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Suppressing softrepeat
Cc: "Pete Zaitcev" <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       stuart_hayes@dell.com
In-Reply-To: <20060221214030.GA12575@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221124308.5efd4889.zaitcev@redhat.com>
	 <20060221210800.GA12102@suse.cz>
	 <d120d5000602211332p16381c16t100f93116cd33539@mail.gmail.com>
	 <20060221214030.GA12575@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> I'm not sure where this would help. The problem is that the DRAC3
> 'holds' the key pressed for full 500 ms before sending the release
> scancde, even if the user pressed it just momentarily. It doesn't
> generate repeat scancodes in this time. This however triggers the
> softrepeat, which is by default set to 250 ms, causing repeated
> characters all the time.
>

Ah, I see. Well, then we really can't help it without fiddling with repeat rate.

--
Dmitry
