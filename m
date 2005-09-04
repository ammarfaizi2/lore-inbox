Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVIDUvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVIDUvO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVIDUvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:51:14 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:48183 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751083AbVIDUvO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:51:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rBdklYnJUad5V2ETzwwGS5L9RthBK8K6Fsv139lfIJX6BTDzLEH+hZRiPyC0n4pD1hZu/7bjjS5Ms/yvA7gRlucgqP3REVDHWA1Cv3L+pKd7aPFjG8aZBvdM3Td6CI2tUi7orVDn3kG6vpH0CLg7hcFIBXsoIJ1nMdVDeItvzLQ=
Message-ID: <dda83e78050904135113b95c4a@mail.gmail.com>
Date: Sun, 4 Sep 2005 13:51:08 -0700
From: Bret Towe <magnade@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 client bug
In-Reply-To: <dda83e78050904124454fc675a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e78050903171516948181@mail.gmail.com>
	 <dda83e7805090320053b03615d@mail.gmail.com>
	 <20050904103523.GA5613@electric-eye.fr.zoreil.com>
	 <dda83e78050904124454fc675a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Bret Towe <magnade@gmail.com> wrote:
> On 9/4/05, Francois Romieu <romieu@fr.zoreil.com> wrote:
> > Bret Towe <magnade@gmail.com> :
> > [...]
> > > after moving some files on the server to a new location then trying to
> > > add the files
> > > to xmms playlist i found the following in dmesg after xmms froze
> > > wonder how many more items i can find...
> >
> > The system includes some binary only stuff. Please contact your vendor
> > or provide the traces for a configuration wherein the relevant module
> > was not loaded after boot. It may make sense to get in touch with
> > nfs@lists.sourceforge.net then.
> 
> the 'binary only stuff' is ati-drivers kernel module and it crashs
> with or without it
> ill provide a 'untainted' trace as soon as i can repeat the bug again

ok without ati-drivers kernel module loaded the computer basicly just
hard locks when
some bug hits dunno if its the same item 

to repeat it tho one needs laptop-mode enabled have xmms playing music
(flac in my case)
which resides on nfs then just put the computer under some local load
for a little bit
till which im guessing it needs to clear some memory or somethin and
it hits this hard lock
or the errors i mailed previously when ati-drivers is loaded
