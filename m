Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSJWIKf>; Wed, 23 Oct 2002 04:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJWIKf>; Wed, 23 Oct 2002 04:10:35 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:47787 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S262905AbSJWIKf>; Wed, 23 Oct 2002 04:10:35 -0400
Subject: Re: 2.4 Ready list - Kernel Hooks
To: Greg KH <greg@kroah.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF8955D2C4.965253CB-ON80256C5B.002C9AA3@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Wed, 23 Oct 2002 09:10:13 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 23/10/2002 09:16:36
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wed, Oct 23, 2002 at 12:09:38AM +0100, Richard J Moore wrote:
>> We created
>> kernel hooks for exactly the same reasons that LSM needs hooks - to
allow
>> ancillary function to exist outside the kernel, to avoid kernel bloat,
to
>> allow more than one function to be called from a given call-back (think
of
>> kdb and kprobes - both need to be called from do_debug).
>
>No, that is NOT the same reason LSM needs hooks!  LSM hooks are there to
>mediate access to various kernel objects, from within the kernel itself.
>Please do not confuse LSM with any of the above projects.
>
>thanks,
>
>greg k-h

I would have to understand what you meant by "mediate between various
kernel objects" to know whether LSM's need for hooks is radically different
to RAS needs. Can you explain further?


Richard

