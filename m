Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271714AbRJJAjm>; Tue, 9 Oct 2001 20:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRJJAjW>; Tue, 9 Oct 2001 20:39:22 -0400
Received: from beta.dmz-us.st.com ([167.4.1.35]:32254 "HELO beta.dmz-us.st.com")
	by vger.kernel.org with SMTP id <S271714AbRJJAjR>;
	Tue, 9 Oct 2001 20:39:17 -0400
From: paul.thacker@st.com
X-OpenMail-Hops: 2
Date: Tue, 9 Oct 2001 17:39:33 -0700
Message-Id: <"H00008fc0420c770.1002673803.phx008.phx.st.com*"@MHS>
Subject: usb_bulk_msg timeout w/ rvmalloc
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     I have written a driver which, in part, facilitates the usb bulk 
     transfer of raw image data. It works fine for small (CIF, QCIF) 
     images, but for larger images, kmalloc will not allocate enough 
     memory. 
     
     I copied the rvmalloc code from the cpia2 driver and used it in place 
     of kmalloc. The memory allocates fine, but usb_bulk_msg now times out 
     when using the pointer to the rvmalloc'd memory. I have been unable to 
     find an instance of an existing driver using rvmalloc in conjunction 
     with usb_bulk_msg. 
     
     Thanks in advance for any advice. Please reply via email - I am not 
     subscribed to the mailing list.
     
     Paul Thacker
     Staff Engineer II
     ST Microelectronics
     paul.thacker@st.com

