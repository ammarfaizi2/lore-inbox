Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268941AbRHFVUA>; Mon, 6 Aug 2001 17:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268952AbRHFVTu>; Mon, 6 Aug 2001 17:19:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:62674 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268941AbRHFVTi>; Mon, 6 Aug 2001 17:19:38 -0400
Date: Mon, 06 Aug 2001 14:18:00 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with 10Mbit ethernet connections on Adaptec Starfire card
Message-ID: <675067451.997107480@mbligh.des.sequent.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I connect an Adaptec Starfire card to a 10Mbit, half duplex ethernet,
it sees very few (though not 0) packets. Debug logging shows that it's
correctly recognising the connection as 10Mbit, half duplex. The port
is unusable like this (despite the odd packet or two).

If I connect a 100Mbit back-to-back with another adaptec, or connect
myself to the same 10Mbit port as before through a 100Mbit switch
(giving me a 100Mbit local connection) it works fine. A tulip board to
the same port (direct @ 10Mbit) also works fine.

Anyone else seen anything like this? Couldn't see anything in the
archives.

Thanks,

Martin.

PS. Linux 2.4.6 kernel. 
