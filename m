Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265607AbUATRTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUATRTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:19:35 -0500
Received: from mail.webmaster.com ([216.152.64.131]:6552 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S265607AbUATRTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:19:32 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Giuliano Pochini" <pochini@denise.shiny.it>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: License question
Date: Tue, 20 Jan 2004 09:19:21 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEDLJLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.58.0401201015250.30196@denise.shiny.it>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 19 Jan 2004, David Schwartz wrote:

> > > Since their code is C++ I already rewote everything in C, but it
> > > also contains the binary firmwares which I can't rewrite. That's
> > > why I asked you about the license.

> > 	Then you have another problem. You can't place something
> > under the GPL if
> > you don't have the source code to it.

> This issue was raised on the list a few months ago. Someone's opinion was
> that the firmware is not executed by the same processor that runs Linux,
> thus it's data, not code.

	The GPL makes no distinctions about what processor runs things, nor does it
make distinctions between data and code.

> Uploading a firmware is like printing an image
> on the screen.

	So what difference is that supposed to make? Quoting the GPL:

The source code for a work means the preferred form of the work for
making modifications to it.  For an executable work, complete source
code means all the source code for all modules it contains, plus any
associated interface definition files, plus the scripts used to
control compilation and installation of the executable.

	Notice it doesn't say that source code only exists for executables. It
simply clarifies what it means by "source code" by explaining what it means
with respect to executables. If you release a package under the GPL that
includes, for example, a JPG image, you would have to give the "preferred
from of [that] work for making modification to it" to any user who requested
it (or otherwise comply with the GPL requirements).

> Anyway I can upload the firmware from userspace. On most
> (but not all) cards I only need the firmware at startup, so I also save
> memory. Some cards also have an ASIC which must be loaded. That data is
> not code because it's not executed.

	Why does it matter whether it's data or code? The GPL doesn't care whether
a work is data or code, it just requires that you provide to a suitably
qualified requester the "preferred form of the work for making modifications
to it". Even data has a "preferred form". Raw versus processed is analogous
to source versus object.

	I think the firmware loader can be a license boundary. Just don't put any
GPL notices in the files that contain the firmware as data. While this isn't
'mere aggregation', the integration is across an API that should be
acceptable as a license boundary.

	DS


