Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281327AbRKUIpJ>; Wed, 21 Nov 2001 03:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281676AbRKUIo7>; Wed, 21 Nov 2001 03:44:59 -0500
Received: from wallext.webflex.nl ([212.115.150.250]:32430 "EHLO
	palm.webflex.nl") by vger.kernel.org with ESMTP id <S281327AbRKUIon>;
	Wed, 21 Nov 2001 03:44:43 -0500
Message-ID: <XFMail.20011121094325.mathijs@knoware.nl>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>
Date: Wed, 21 Nov 2001 09:43:25 +0100 (CET)
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>
Subject: RE: copy to user
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Nov-2001 Luis Miguel Correia Henriques wrote:
> I suppose now you can understand why SIGSTOP won't work. Hope you can help
> me :)

how about making a signal handler for SIGUSR1 that checks a global variable and
loops. an other signal handler for SIGUSR2 to clear the variable so the SIGUSR1
handler can exit.

All in user space. (to delay execution kill -USR1 $pid, to continue: kill -USR2
$pid)

        me


-- 
        me
