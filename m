Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbRFBSQx>; Sat, 2 Jun 2001 14:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262651AbRFBSQn>; Sat, 2 Jun 2001 14:16:43 -0400
Received: from mout0.freenet.de ([194.97.50.131]:20156 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S262649AbRFBSQi> convert rfc822-to-8bit;
	Sat, 2 Jun 2001 14:16:38 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: Chris Mason <mason@suse.com>
Subject: Re: [2.4.5 and all ac-Patches] massive file corruption with reiser or NFS
Date: Sat, 2 Jun 2001 20:13:44 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <273360000.991500124@tiny>
In-Reply-To: <273360000.991500124@tiny>
Cc: "Kernel-Mailingliste" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01060220134401.04097@athlon>
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by susi.maya.org id f52IGe701285
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag,  2. Juni 2001 18:42 schrieben Sie:
> On Saturday, June 02, 2001 02:41:04 PM +0200 Andreas Hartmann
>
> <andihartmann@freenet.de> wrote:
> > Am Samstag,  2. Juni 2001 12:52 schrieb Rasmus Bøg Hansen:
> >> On Sat, 2 Jun 2001, Andreas Hartmann wrote:
> >> > I got massive file corruptions with the kernels mentioned in the
> >> > subject. I can reproduce it every time.
> >> >
> >> >> You cannot use NFS on reiserfs unless you apply the knfsd patch. Look
> >> >> at
> >>
> >> www.namesys.com.
> >>
> > > Thank you very much for your advice.
> > > I tested your suggestion and run the machine without NFS-mounted
> > > devices
> >
> > - it  seems to be working fine. > > Anyway - I'm wondering why I didn't
> > get any problem until 2.4.4ac10 with this  configuration without the
> > appropriate patch on the client or on the server?
>
> The problem only happens when the clients do an operation on a file that
> has gone out of cache on the server.  Under light load, this might happen
> very rarely.

The load didn't change. YOu can forget the load, it's very small. It's my 
private server and I'm doing always the same thing via NFS - compiling e.g. 
This has been working fine until 2.4.4.ac10, afterwards it has been broken.

>
> You only need the patch on the server.

My experiences today are others: I need the patch on both, the server and the 
client (both 2.4.5) to get it working. See the other mailing to Alan in the 
list.

Regards,
Andreas Hartmann
