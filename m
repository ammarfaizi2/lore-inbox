Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQKFROE>; Mon, 6 Nov 2000 12:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129685AbQKFRNz>; Mon, 6 Nov 2000 12:13:55 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:6551 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129572AbQKFRNp>; Mon, 6 Nov 2000 12:13:45 -0500
From: Christoph Rohland <cr@sap.com>
To: aprasad@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: to resize shared memory segment by using shmctl
In-Reply-To: <CA25698F.005C921F.00@d73mta05.au.ibm.com>
Organisation: SAP LinuxLab
Date: 06 Nov 2000 18:13:20 +0100
In-Reply-To: aprasad@in.ibm.com's message of "Mon, 6 Nov 2000 16:04:53 +0530"
Message-ID: <qwwbsvt81n3.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 Nov 2000, aprasad@in.ibm.com wrote:
> Hi, is it possible to change the size of a preexisting shared memory
> segment by using shmctl?
> 
> AIX has comand SHM_SIZE to shmctl to resize any existing shared
> memory segment.  can it be done without recreating the whole thing
> in linux?

No that's not possible in Linux. With 2.4 you can use posix shm and
use ftruncate to resize it.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
