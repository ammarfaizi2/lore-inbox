Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbUKETv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbUKETv3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUKETv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:51:29 -0500
Received: from [61.48.52.143] ([61.48.52.143]:17902 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261163AbUKETvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:51:17 -0500
Date: Fri, 5 Nov 2004 10:43:04 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200411051843.iA5Ih4q28451@adam.yggdrasil.com>
To: davids@webmaster.com
Subject: RE: Possible GPL infringement in Broadcom-based routers
Cc: jp@enix.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
>> 	I think you're missing the idea that that such drivers are
>> _contributory_ infringement to the direct infringement that occurs when
>> the user loads the module.

>	Except that loading the module is not infringement. The GPL does not
>restrict use of GPL'd code in any way.

>> In other words, even for a driver that has
>> not a byte of code derived from the kernel, if all its uses involve it
>> being loaded into a GPL'ed kernel to form an infringing derivative
>> work in RAM by the user committing direct copyright infringement against
>> numerous GPL'ed kernel components, then it fails the test of having
>> a substantial non-infringing use, as established in the Betamax decision,
>> and distributing it is contributory infringement of those GPL'ed
>> components of the kernel.

>	In order for there to be an "infringing derivative work", some clause of
>the GPL would have to be infringed. There exists no clause in the GPL that
>restricts the *creation* of derivative works that are not distributed.

	The GPL is a grant of permission.  So, if you have an activity
that is restricted by copyright, you have to find something in the GPL
that gives you permission.  It's not just me saying that.  A representative
from the FSF explained that to room of ~50 lawyers and ~50 lay people
at a seminar that I went to on it.

>	If your argument were correct, then no non-GPL'd software could *ever* be
>distributed for Linux. You see, loading that software would create an
>"infringing derivative work" in the memory of the computer running it,
>combining the Linux kernel with the software.

	The FSF has addressed the question of interpretation of the
GPL with respect to how running a program in RAM may not by itself
make it a derivative work of other programs in RAM while dynamically
loading a module into a program (including a kernel) does in their
FAQ at http://www.gnu.org/licenses/gpl-faq.html:

| [...]
| What constitutes combining two parts into one program? This is a legal
| question, which ultimately judges will decide. We believe that a
| proper criterion depends both on the mechanism of communication (exec,
| pipes, rpc, function calls within a shared address space, etc.) and
| the semantics of the communication (what kinds of information are
| interchanged).
| 
|  If the modules are included in the same executable file, they are
| definitely combined in one program. If modules are designed to run
| linked together in a shared address space, that almost surely means
| combining them into one program.
| 
|  By contrast, pipes, sockets and command-line arguments are
| communication mechanisms normally used between two separate
| programs. So when they are used for communication, the modules
| normally are separate programs. But if the semantics of the
| communication are intimate enough, exchanging complex internal data
| structures, that too could be a basis to consider the two parts as
| combined into a larger program.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
