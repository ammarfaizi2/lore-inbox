Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261741AbREUHR6>; Mon, 21 May 2001 03:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbREUHRs>; Mon, 21 May 2001 03:17:48 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:10765 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261741AbREUHRn>;
	Mon, 21 May 2001 03:17:43 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105210716.f4L7Gte504365@saturn.cs.uml.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
To: dwguest@win.tue.nl (Guest section DW)
Date: Mon, 21 May 2001 03:16:55 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), Mauelshagen@sistina.com,
        thomasko321k@gmx.at (Thomas Kotzian),
        helgehaf@idb.hist.no (Helge Hafting), linux-kernel@vger.kernel.org
In-Reply-To: <20010517113924.B9270@win.tue.nl> from "Guest section DW" at May 17, 2001 11:39:24 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW writes:
> On Thu, May 17, 2001 at 02:35:55AM -0400, Albert D. Cahalan wrote:

>> The PC partition table has such an ID. The LILO change log
>> mentions it. I think it's 6 random bytes, with some restriction
>> about being non-zero.
>
> You are confused. The partition table contains IDs, but these are
> the numbers like 83 for a Linux partition. No disk-identifying numbers.

Care to explain "duplicate MBR signature handling" in the GPT FAQ?
While describing the new-style partitions, Microsoft mentions that
Windows 2000 has a way to mark old-style ("MBR") partitions:

: 58. What happens if a duplicate Disk or Partition GUID is detected? 
: Windows Whistler will generate new GUIDs for any duplicate Disk GUID,
: MSR Partition GUID, or MSR basic data GUID upon detection. This is
: similar to the duplicate MBR signature handling in Windows 2000.
: Duplicate GUIDs on a dynamic container or database partition
: cause unpredictable results.

Well, the way to test this would be with Windows 2000, two disks,
and a Linux rescue disk that has "dd" on it. See what gets changed
when the "duplicate MBR signature handling in Windows 2000" runs.

