Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154344AbPGZTyu>; Mon, 26 Jul 1999 15:54:50 -0400
Received: by vger.rutgers.edu id <S154301AbPGZTye>; Mon, 26 Jul 1999 15:54:34 -0400
Received: from franz.videotron.net ([205.151.222.14]:65385 "EHLO franz.videotron.net") by vger.rutgers.edu with ESMTP id <S154372AbPGZTyV>; Mon, 26 Jul 1999 15:54:21 -0400
Message-ID: <379CBE18.B89F1837@info.polymtl.ca>
Date: Mon, 26 Jul 1999 15:59:20 -0400
From: Karim Yaghmour <karym@info.polymtl.ca>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.10 i686)
X-Accept-Language: French/France, fr-FR, French/Canada, fr-CA, en
MIME-Version: 1.0
To: rjwalsh@durables.org
CC: linux-kernel@vger.rutgers.edu
Subject: Re: kernel profiling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, 8 Jul 1999, Robert Walsh wrote:

> We're currently profiling the kernel NFS daemon (the entire path from
> network to disk) using SPECsfs and other benchmarking mechanisms, and
> before I start working on a home-grown profiling mechanism I'd like to
> make sure I'm not reinventing the wheel.

You might want to check on the tool i've been working on, which enables
you to see exactly what if happening on your system at all times. It
would enable you to see what time is spent in kernel, what time is
spent in the rest of the system, and why.

Moreover, the mechanisms I use are easily extendable. Therefore, if
you find the information given insufficient, you can make the kernel
generate more information without modifying too many things.

You can find the Linux 
Trace Toolkit at the following address :

http://www.info.polymtl.ca/users/karym/www/trace/

The information on how to use it is there and so is some information
on how it works. If you need more info, don't hesitate to contact me
if you need more information.

Of course, it's all under GPL ...

Regards.

==============================================
              Karim Yaghmour
          karym@info.polymtl.ca
            Computer Engineer
      Ecole Polytechnique de Montreal
==============================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
