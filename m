Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWC0TM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWC0TM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWC0TM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:12:28 -0500
Received: from wproxy.gmail.com ([64.233.184.226]:62954 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751225AbWC0TM1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:12:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W2rsYgICYFdRGyoZ0fHVY4zvTw30qQ+e+luiK34FRejUbboygLGEPpGLGRfvTwKgIoD0+sMcY+l7HgtgzafhNhc50o8J+l6fjGO9dKK9Esb3cZej2Agcsz25UhlJLnbdzpYhbF0WmtadQOi/I+QkwsJmzo8qOCtJZXKs9kA+nJI=
Message-ID: <d120d5000603271112r35ba7100jceb8aaf3e8bf8c70@mail.gmail.com>
Date: Mon, 27 Mar 2006 14:12:26 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Romano Giannetti" <romanol@upcomillas.es>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: ALPS stop worked between 2.6.13 and 2.6.16
In-Reply-To: <20060327190826.GA18193@pern.dea.icai.upcomillas.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060327153624.GC8679@pern.dea.icai.upcomillas.es>
	 <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com>
	 <20060327190826.GA18193@pern.dea.icai.upcomillas.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/06, Romano Giannetti <romanol@upcomillas.es> wrote:
>
> On Mon, Mar 27, 2006 at 11:05:26AM -0500, Dmitry Torokhov wrote:
>
> > Hi,
> >
> > According to your dmesg your ALPS touchpas awas successfully detected
> > by the kernel. Please make sure that you have updated udev package.
> >
>
> Udev is 054 (as per Mandriva 2005). Is that the culprit?

[~/linux] grep udev Documentation/Changes
o  udev                   071                     # udevinfo -V
...


--
Dmitry
