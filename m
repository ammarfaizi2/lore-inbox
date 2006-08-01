Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWHANRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWHANRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWHANRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:17:30 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:2235 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751308AbWHANRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:17:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=um6u5o1uUtgh7RmBqMxuo4z7CU2t3WC4b3Lf8iLtHj2NnYatDPA2JwoGmg7UPvRi3kqsHdRy2SzQ+6dEE215ejxZb7rl41OWyF9FEjJOqVuGvezNe8JZsJHVhGm0C5O+FZYNLP8kpxDa5Jp5GxKJcKQRy9zx6pELzxtpPSRc7Bc=
Message-ID: <e084545e0608010617h9941cbchd366cf3ee6bcb0d0@mail.gmail.com>
Date: Tue, 1 Aug 2006 15:17:27 +0200
From: "=?ISO-8859-1?Q?Omar_A=EFt_Mous?=" <omar.aitmous@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Connection tracking synchronization module
Cc: jp@enix.org, sebastien.wacquiez@enix.fr, smagghue@gmail.com,
       risk_colta@hotmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a kernel module to allow real-time synchronization of connection
tracking tables between two linux routers. It will be useful for people willing
to achieve high availability of stateful firewalls, or NAT routers. It's our
first attempt at kernel hacking, so there is probably many errors and things to
fix, but it Works For Us (TM). you can even test it without recompiling your
kernel. see attached README file for the gory details. You would be so kind to
cc: us when replying ! :)
Latest version can be found here :
http://enix.fr/projects/syntrack/browser/tarballs/revision-90.tar.gz?format=raw
Or here for future releases :
http://enix.fr/projects/syntrack/browser/tarballs
