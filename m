Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVGZTAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVGZTAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVGZS6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:58:35 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:56775 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S262029AbVGZS5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:57:44 -0400
Message-ID: <42E687A3.9090003@davyandbeth.com>
Date: Tue, 26 Jul 2005 13:57:39 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: top misinforming with threads in the mix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I wrote a process that spawns a thread and then the thread just goes to 
town using CPU (on purpose) while the main process waits on it. 


On linux-2.6.3 and top 3.1.15 top shows that the machine is 0% idle, but 
it does not show any processes taking any significant CPU time. 

However, things show fine on linux-2.6.11 with top 3.2.5

Does anyone know if this was a top deficiency or something the kernel 
wasn't reporting correctly?

Thanks,
  Davy


