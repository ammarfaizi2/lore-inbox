Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTKCRMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTKCRMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:12:50 -0500
Received: from sea2-dav50.sea2.hotmail.com ([207.68.164.22]:59653 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262188AbTKCRMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:12:49 -0500
X-Originating-IP: [12.145.34.101]
X-Originating-Email: [san_madhav@hotmail.com]
From: "sankar" <san_madhav@hotmail.com>
To: <linux-kernel@vger.kernel.org>, "Arve Knudsen" <aknuds-1@broadpark.no>
References: <Sea2-DAV35RuMrzpeSK0000db71@hotmail.com> <oprxxqjgqeq1sf88@mail.broadpark.no>
Subject: Re: pthread mutex question
Date: Mon, 3 Nov 2003 09:07:47 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Sea2-DAV50kJcj3CRIn0000c736@hotmail.com>
X-OriginalArrivalTime: 03 Nov 2003 17:12:37.0249 (UTC) FILETIME=[ADF8AF10:01C3A22D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for the info...I lookd in boost.org..It does not have the source code
for timed mutex.It just says how it shd work..Pls let me know if I am
missing something  here..
----- Original Message -----
From: "Arve Knudsen" <aknuds-1@broadpark.no>
To: "sankar" <san_madhav@hotmail.com>; <linux-kernel@vger.kernel.org>
Sent: Friday, October 31, 2003 5:31 PM
Subject: Re: pthread mutex question


> Its C++, but you could have a look at the boost::thread::timed_mutex
> (www.boost.org) implementation, which makes use of pthread_cond_timedwait.
>
> Regards
>
> Arve Knudsen
>
> On Fri, 31 Oct 2003 16:43:14 -0800, sankar <san_madhav@hotmail.com> wrote:
>
> > Hi,
> > I am looking for an idea as to how to implement timed mutex using
pthread
> > libraries on linux.
> > Basically I want to associate a timeout value with the wait function i,e
> > pthread_mutex_lock() which returns once the timeout expires instaed of
> > waiting for ever.
> > Pls help
> >
> > thx..
> >
> > Sankarshana M
>
