Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154114AbQC1Pf2>; Tue, 28 Mar 2000 10:35:28 -0500
Received: by vger.rutgers.edu id <S153994AbQC1Pa0>; Tue, 28 Mar 2000 10:30:26 -0500
Received: from field.videotron.net ([205.151.222.108]:65222 "EHLO field.videotron.net") by vger.rutgers.edu with ESMTP id <S154040AbQC1P1x>; Tue, 28 Mar 2000 10:27:53 -0500
Date: Tue, 28 Mar 2000 10:29:15 -0500
From: Karim Yaghmour <karym@opersys.com>
Subject: [UPDATE/RFC/PATCH] Linux Trace Toolkit
To: linux-kernel@vger.rutgers.edu
Message-id: <38E0CFCB.CE6EB317@opersys.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.13 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: French/France, fr-FR, French/Canada, fr-CA, en
Sender: owner-linux-kernel@vger.rutgers.edu


UPDATE:
This is to inform you that a new version of the Linux Trace Toolkit has
been released. Version 0.9.1 marks a mile-stone because of it's ability
to manipulate very large traces and it's usage of memory mapping to reduce
data transfers from the kernel to user-space. Most of the changes are
not visible (the command-line options and interface have not changed),
but the underlying mechanisms have been completely re-written. Yet, the
architecture remains the same.

RFC:
Given the insight LTT allows into Linux' functionnality, it's low-overhead,
it's modularity and it's flexibility, it would be very interesting to see
the trace functionnality incorporated into the standard kernel tree. That said,
the modifications into the kernel's code are minimal and completely
configurable. That is, you only need to enable or disable the kernel tracing
option in the configuration menu in order to include or remove the tracing
facilities from the kernel. The said patch has not been included with this
message because of it's size (mainly due to files added), but it can be
retrieved from LTT's web site (given below). It would be important to stress
that unlike the kernel debugger patch or a profiling patch, this patch does
not strictly serve kernel developers. It is actually meant to be used by
developpers and system administrators who would like to get more insight into
the system's behavior. Therefore the public is quite broad. As has been
suggested by many, this patch can also serve as a basis for an enhanced
security auditing system or an intrusion detection scheme. The hooks are there
or are quite easy to implement. I would very much like to hear what members of
the list think about this issue. (I have no specific kernel version in sight for
including this patch. 2.4 would be ideal and it would actually be easy since the
patch doesn't have that much influence on it's surroundings, but I'll leave this
one for Linus.)

Take a look at LTT's web page :
  http://www.opersys.com/LTT

Best Regards.

===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
