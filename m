Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADGEh>; Thu, 4 Jan 2001 01:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRADGE1>; Thu, 4 Jan 2001 01:04:27 -0500
Received: from [202.106.187.156] ([202.106.187.156]:48396 "HELO sina.com")
	by vger.kernel.org with SMTP id <S129348AbRADGER>;
	Thu, 4 Jan 2001 01:04:17 -0500
Date: Thu, 4 Jan 2001 14:02:56 +0800
From: hugang <linuxbest@sina.com>
To: linux-kernel@vger.kernel.org
Subject: Abort x86 assemble code
Message-Id: <20010104140256.4ce9f12b.linuxbest@sina.com>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.4.0-prerelease; i686)
Organization: soul
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all
	
	I have following code ,and I can not understand the mark line,who can tell me.thanks.
--------------------------------------------------------------
00000eb8 movb   (%ebx),%al      <<IMPORTANT 1-4>>
00000eba incl   %ebx
00000ebb movl   %edi,%ecx
00000ebd shrl   $0x8,%ecx
00000ec0 movl   %edi,%edx
00000ec2 xorb   %dl,%al
00000ec4 movzbl %al,%eax
00000ec7 xorl   0x400dec(,%eax,4),%ecx					????<-----------------What it to do.
00000ece movl   %ecx,%edi
00000ed0 movl   %esi,%eax               <-- jmp here
00000ed2 decl   %esi
00000ed3 orl    %eax,%eax
00000ed5 jne    00000eb8
00000ed7 movl   %edi,0x406894           <- 1-4 see here
00000edd popl   %esi
00000ede popl   %edi
00000edf popl   %ebx

________________________________________________________________
thanks .

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
