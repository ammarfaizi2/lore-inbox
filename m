Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTAEARC>; Sat, 4 Jan 2003 19:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAEARC>; Sat, 4 Jan 2003 19:17:02 -0500
Received: from h-64-105-35-112.SNVACAID.covad.net ([64.105.35.112]:6318 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261854AbTAEARB>; Sat, 4 Jan 2003 19:17:01 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 4 Jan 2003 16:25:27 -0800
Message-Id: <200301050025.QAA07630@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Honest does not pay here ...
Cc: andre@linux-ide.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>        I believe that the illegality of proprietary kernel modules
>has resulting in more GPL-compatible kernel code than without such
>a restriction.

	Andre has informed me of a posting made by Linus to the
gnu.misc.discuss newsgroup (Message-ID
"4b0rbb$5iu@klaava.helsinki.fi") on December 17, 1995 where he
basically gave his permission for the EXPORT_SYMBOL
vs. EXPORT_SYMBOL_GPL system hereby proprietary modules that call only
EXPORT_SYMBOL symbols are allowed:

http://groups.google.com/groups?as_umsgid=4b0rbb%245iu%40klaava.helsinki.fi

	I am not a lawyer, so don't take this as legal advice.  What
follows is just my layman's opinion.

	I think the permission in Linus's gnu.misc.discuss cannot
apply retroactively to the contributions of others that were
contributed before that message was posted without those copyright
holders agreeing.  It might help one argue that contributions by
others after that time included that implicit grant, but I wonder to
what degree you one can expect that contributors should have been
aware of a gnu.misc.discuss posting (for example, compared to being
aware of /usr/src/linux/COPYING).  I wasn't aware of it until today.

	I also doubt the theory that calling only through the
EXPORT_SYMBOL functions that Linus wrote makes Linus's permission
sufficient for binary modules as is theorized at the bottom of this URL:
http://www.gcom.com/home/support/whitepapers/linux-gnu-license.html.

	Running Linux still involves using a lot of other people's
contributions in ways restricted by copyright, generally requiring one
follow the conditions under which permission to do these things will
be granted (usually the GNU General Public License; some are less
restricted).  Arguing that a compatability layer allows you to do
something with the software underneat that is forbidden by copyright
and not a permission granted by the copyright holder sounds to me like
saying that Netscape's compatability layer gives you permission to
make copies of Microsoft Windows (software potentially behind the
layer) beyond the restrictions of copyright and whatever permission
you already have from microsoft.  I know the anaology isn't perfect,
but I believe the relevant aspects are.

	Anyhow, I thought I should post this information, as it was
news to me, and I my posting of a few hours aga alone would otherwise
propagate my own previous ignorance of an important element of this
issue.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
